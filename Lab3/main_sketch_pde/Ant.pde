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
  private float USE_RATE = .995;//rate of pheromone evaporation
  private float WANDER_CHANCE = .92;
  private float MAX_SPEED = 1.0;

  int bored = 0;

  Map homeMap;
  Map foodMap;

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
    // Reset acceleration each step
    acceleration.mult(0);

    //add a random deviation from the path. Without it 
    //the path looks like a line
    if (random(1) > WANDER_CHANCE) {
      acceleration.add(new PVector(random(-1, 1), random(-1, 1)));
    }
    if (random(1) > .99) bored += floor(random(15));//adds a random period when ant ignores pheromones

    if (bored > 0) {
      // Ignore pheromones if bored
      bored--;
    } else {
      //follow pheromone trails
      if (hasFood) {
        //Look for home
        int[] direction = homeMap.getStrongest(intX, intY);
        acceleration.add(new PVector(direction[0] * random(1.5), direction[1] * random(1.5)));
      } else {
        // Look for food
        int[] direction = foodMap.getStrongest(intX, intY);
        acceleration.add(new PVector(direction[0] * random(1.5), direction[1] * random(1.5)));
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

    // Move the ant
    location.add(velocity);
    intX = floor(location.x);
    intY = floor(location.y);

    // Leave pheromone trails only if the ant has moved to a new pixel
    if (lastX != intX || lastY != intY) {
      if (hasFood) {
        // Leave food pheromone trail
        foodPher *= USE_RATE;
        foodMap.setValue(intX, intY, foodPher);
      } else {
        //:Leave home pheromone trail
        homePher *= USE_RATE;
        homeMap.setValue(intX, intY, homePher);
      }
    }

    // Update last known position
    lastX = intX;
    lastY = intY;
  }
    void disperse(float mouseX, float mouseY) {
       // Calculate the direction away from the mouse click
        PVector mouseLocation = new PVector(mouseX, mouseY);
        PVector fleeDirection = PVector.sub(location, mouseLocation);
        float distance = fleeDirection.mag();

        // Normalize the direction and scale by a very high "explosive" force factor
        fleeDirection.normalize();

        // Set the force strength to simulate a bomb effect
        float forceMagnitude = 500.0 / (distance + 1);  // Large initial force, scaled by distance
        fleeDirection.mult(forceMagnitude);

        // Apply this explosive force directly to the ant's velocity for an instant effect
        velocity.add(fleeDirection);
    }
}
