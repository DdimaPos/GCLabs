color ANT_COLOR = color(68, 0, 8);
int DIRT_R = 217;
int DIRT_G = 165;
int DIRT_B = 78;
color DIRT_COLOR = color(DIRT_R, DIRT_G, DIRT_B);
color FOOD_COLOR = color(158, 55, 17);
int HOME_R = 96;
int HOME_G = 85;
int HOME_B = 33;
color PHER_HOME_COLOR = color(HOME_R, HOME_G, HOME_B);
int FOOD_R = 255;
int FOOD_G = 255;
int FOOD_B = 255;
color PHER_FOOD_COLOR = color(FOOD_R, FOOD_G, FOOD_B);

Colony col;
Food food;
Map pherHome;
Map pherFood;

void setup() {
    size(900, 506);
    background(DIRT_COLOR);
    noStroke();

    pherHome = new Map(width, height);
    pherFood = new Map(width, height);
    col = new Colony(100, 100, 300, pherHome, pherFood);
    food = new Food(width, height);

    //add some food crumbs
    for (int i = 0; i < 10; i++) {
        food.addFood(500 + int(random(-50, 50)), 300 + int(random(-50, 50)));
    }
}

void draw() {
    background(DIRT_COLOR);

    //add food when mouse is pressed
    if (mousePressed && mouseButton == LEFT) {
        food.addFood(mouseX, mouseY);
    }
    
    loadPixels();
    for (int i = 0; i < pherHome.length; i++) {
        color pixelColor;
        if (food.getValue(i)) {
            //draw food
            pixels[i] = FOOD_COLOR;
        } else {
            float homeAlpha = pherHome.getPercentage(i);
            float foodAlpha = pherFood.getPercentage(i);
            if (homeAlpha > 0 || foodAlpha > 0) {
                //draw pheromones
                int pixel_r = int(HOME_R * homeAlpha + DIRT_R * (1 - homeAlpha));
                int pixel_g = int(HOME_G * homeAlpha + DIRT_G * (1 - homeAlpha));
                int pixel_b = int(HOME_B * homeAlpha + DIRT_B * (1 - homeAlpha));

                pixel_r = int(FOOD_R * foodAlpha + pixel_r * (1 - foodAlpha));
                pixel_g = int(FOOD_G * foodAlpha + pixel_g * (1 - foodAlpha));
                pixel_b = int(FOOD_B * foodAlpha + pixel_b * (1 - foodAlpha));

                //optimize pixel color calculation by using bitwise color calculation(increased fps)
                pixelColor = 255 << 24 | pixel_r << 16 | pixel_g << 8 | pixel_b;
                pixels[i] = pixelColor;
            }
        }
    }
    updatePixels();

    //draw ants
    for (int i = 0; i < col.ants.length; i++) {
        Ant thisAnt = col.ants[i];

        thisAnt.step();

        int thisXi = thisAnt.intX;
        int thisYi = thisAnt.intY;
        float thisXf = thisAnt.location.x;
        float thisYf = thisAnt.location.y;

        fill(ANT_COLOR);

        if (thisAnt.hasFood) {
            fill(FOOD_COLOR);
            if (thisXi > col.x - 10 && thisXi < col.x + 10 && thisYi > col.y - 10 && thisYi < col.y + 10) {
                //close enough to home
                thisAnt.hasFood = false;
                thisAnt.homePher = 100;
            }
        } else if (food.getValue(thisXi, thisYi)) {
            thisAnt.hasFood = true;
            thisAnt.foodPher = 100;
            food.bite(thisXi, thisYi);
        }

        if (abs(thisAnt.velocity.x) > abs(thisAnt.velocity.y)) {
            //horizontal ant
            rect(thisXf, thisYf, 3, 2);
        } else {
            //vertical ant
            rect(thisXf, thisYf, 2, 3);
        }
    }

    //evaporate pheromones
    pherHome.step();
    pherFood.step();
}
