/*class Ant {
  PVector location;
  PVector velocity;
  PVector acceleration;
  int intX, intY;
  int lastX, lastY;
  int homeX, homeY;

  boolean hasFood = false;

  float homePher = 100;
  float foodPher = 100;
  private float USE_RATE = .995; // Rate of pheromone evaporation
  private float WANDER_CHANCE = .92;
  private float MAX_SPEED = 1.0;

  int bored = 0;

  Map homeMap;
  Map foodMap;

  //explosion-related properties
  boolean dispersing = false;
  float explosionDecay = 0.97;               //decay rate for velocity to slow down
  float explosionInitialVelocity = 60.0;     //high initial velocity for explosion
  float maxExplosionDistance = 500.0;        //maximum effective distance for the explosion
  PVector explosionDirection;

  Ant(int _x, int _y, Map _homePher, Map _foodMap) {
    intX = homeX = _x;
    intY = homeY = _y;
    location = new PVector(_x, _y);
    velocity = new PVector(random(-1, 1), random(-1, 1));
    acceleration = new PVector(0, 0);
    homeMap = _homePher;
    foodMap = _foodMap;
  }

  void step() {
    acceleration.mult(0);

    //apply decaying explosion effect if dispersing
    if (dispersing) {
      //decay the velocity to slow down over time
      velocity.mult(explosionDecay);

      //stop dispersing once velocity is minimal
      if (velocity.mag() < 0.2) {
        dispersing = false;
        velocity.limit(MAX_SPEED);  //restore to normal speed limits
      }
    } else {
      if (random(1) > WANDER_CHANCE) {
        acceleration.add(new PVector(random(-1, 1), random(-1, 1)));
      }
      if (random(1) > .99) bored += floor(random(15)); 

      if (bored > 0) {
        bored--;
      } else {
        if (hasFood) {
          int[] direction = homeMap.getStrongest(intX, intY);
          acceleration.add(new PVector(direction[0] * random(1.5), direction[1] * random(1.5)));
        } else {
          int[] direction = foodMap.getStrongest(intX, intY);
          acceleration.add(new PVector(direction[0] * random(1.5), direction[1] * random(1.5)));
        }
      }
    }

    //make the ant "bounce" off edges
    if (location.x < 2) velocity.x = abs(velocity.x);
    if (location.x > width - 2) velocity.x = -abs(velocity.x);
    if (location.y < 2) velocity.y = abs(velocity.y);
    if (location.y > height - 2) velocity.y = -abs(velocity.y);

    //update velocity and apply a speed limit
    velocity.add(acceleration);
    velocity.limit(MAX_SPEED);

    //move the ant
    location.add(velocity);
    intX = floor(location.x);
    intY = floor(location.y);

    if (lastX != intX || lastY != intY) {
      if (hasFood) {
        foodPher *= USE_RATE;
        foodMap.setValue(intX, intY, foodPher);
      } else {
        homePher *= USE_RATE;
        homeMap.setValue(intX, intY, homePher);
      }
    }

    //update last known position
    lastX = intX;
    lastY = intY;
  }

  //method to apply explosive force on mouse click, with distance-based scaling
  void disperse(float mouseX, float mouseY) {
    dispersing = true;

    //calculate direction away from the click point
    PVector mouseLocation = new PVector(mouseX, mouseY);
    explosionDirection = PVector.sub(location, mouseLocation);

    //get the distance from the mouse click
    float distance = explosionDirection.mag();

    //normalize direction to apply force
    explosionDirection.normalize();

    //calculate the force based on the distance: Use inverse square law for strong impact close to the mouse
    float distanceFactor = max(0, (maxExplosionDistance - distance) / maxExplosionDistance); 
    //use inverse square law to make the effect stronger the closer the ant is
    if (distance > 0) {
      distanceFactor = 1.0 / (distance * distance * 0.005);  // Inverse square scaling
    }

    //set the initial explosive velocity
    velocity = PVector.mult(explosionDirection, explosionInitialVelocity * distanceFactor);
  }
}

*/



class Ant {
  PVector location;
  PVector velocity;
  PVector acceleration;
  int intX, intY;
  int lastX, lastY;
  int homeX, homeY;

  boolean hasFood = false;

  float homePher = 100;
  float foodPher = 100;
  private float USE_RATE = .995; // Rate of pheromone evaporation
  private float WANDER_CHANCE = .92;
  private float MAX_SPEED = 1.0;

  int bored = 0;

  Map homeMap;
  Map foodMap;

  // Falling behavior
  float GRAVITY = 0.2;      // Gravity acceleration
  float TERMINAL_VELOCITY = 5.0; // Max falling speed
  boolean hasHitGround = false; // Track if the ant has hit the ground

  // Explosion-related properties
  boolean dispersing = false;
  float explosionDecay = 0.97;               // Decay rate for velocity to slow down
  float explosionInitialVelocity = 60.0;     // High initial velocity for explosion
  float maxExplosionDistance = 500.0;        // Maximum effective distance for the explosion
  PVector explosionDirection;

  Ant(int _x, int _y, Map _homePher, Map _foodMap) {
    intX = homeX = _x;
    intY = homeY = _y;
    location = new PVector(_x, _y);
    velocity = new PVector(random(-1, 1), random(-1, 1));
    acceleration = new PVector(0, 0);
    homeMap = _homePher;
    foodMap = _foodMap;
  }

  void step() {
    acceleration.mult(0);

    if (hasFood) {
      // Apply gravity if carrying food
      if (!hasHitGround) {
        acceleration.add(new PVector(0, GRAVITY)); // Gravity pulls down

        // Limit falling speed to terminal velocity
        if (velocity.y > TERMINAL_VELOCITY) {
          velocity.y = TERMINAL_VELOCITY;
        }
      }
    } else if (dispersing) {
      // Apply decaying explosion effect if dispersing
      velocity.mult(explosionDecay);
      if (velocity.mag() < 0.2) {
        dispersing = false;
        velocity.limit(MAX_SPEED);  // Restore to normal speed limits
      }
    } else {
      if (random(1) > WANDER_CHANCE) {
        acceleration.add(new PVector(random(-1, 1), random(-1, 1)));
      }
      if (random(1) > .99) bored += floor(random(15)); 

      if (bored > 0) {
        bored--;
      } else {
        if (hasFood) {
          int[] direction = homeMap.getStrongest(intX, intY);
          acceleration.add(new PVector(direction[0] * random(1.5), direction[1] * random(1.5)));
        } else {
          int[] direction = foodMap.getStrongest(intX, intY);
          acceleration.add(new PVector(direction[0] * random(1.5), direction[1] * random(1.5)));
        }
      }
    }

    // Make the ant "bounce" off edges
    if (location.x < 2) velocity.x = abs(velocity.x);
    if (location.x > width - 2) velocity.x = -abs(velocity.x);
    if (location.y < 2) velocity.y = abs(velocity.y);

    // Handle ground collision if falling
    if (hasFood && location.y > height - 2) {
      hasHitGround = true; // Stop falling
      velocity.y = 0;      // Reset vertical velocity
      velocity.x = 0;
      acceleration.y = 0;  // Cancel vertical acceleration
    }

    // Update velocity and apply a speed limit
    velocity.add(acceleration);

    // Ensure speed is within limits for normal motion
    if (!hasFood || hasHitGround) {
      velocity.limit(MAX_SPEED);
    }

    // Move the ant
    location.add(velocity);
    intX = floor(location.x);
    intY = floor(location.y);

    if (lastX != intX || lastY != intY) {
      if (hasFood) {
        foodPher *= USE_RATE;
        foodMap.setValue(intX, intY, foodPher);
      } else {
        homePher *= USE_RATE;
        homeMap.setValue(intX, intY, homePher);
      }
    }

    // Update last known position
    lastX = intX;
    lastY = intY;
  }

  // Method to apply explosive force on mouse click, with distance-based scaling
  void disperse(float mouseX, float mouseY) {
    dispersing = true;

    // Calculate direction away from the click point
    PVector mouseLocation = new PVector(mouseX, mouseY);
    explosionDirection = PVector.sub(location, mouseLocation);

    // Get the distance from the mouse click
    float distance = explosionDirection.mag();

    // Normalize direction to apply force
    explosionDirection.normalize();

    // Calculate the force based on the distance: Use inverse square law for strong impact close to the mouse
    float distanceFactor = max(0, (maxExplosionDistance - distance) / maxExplosionDistance); 
    if (distance > 0) {
      distanceFactor = 1.0 / (distance * distance * 0.005);  // Inverse square scaling
    }

    // Set the initial explosive velocity
    velocity = PVector.mult(explosionDirection, explosionInitialVelocity * distanceFactor);
  }
}
