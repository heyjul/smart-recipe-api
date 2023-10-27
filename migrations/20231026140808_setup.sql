-- UNIT_CATEGORY
CREATE TABLE UNIT_CATEGORY (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    label VARCHAR(255) NOT NULL
);

-- UNIT
CREATE TABLE UNIT (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    label VARCHAR(255) NOT NULL,
    category INT NOT NULL,
    CONSTRAINT FK_UNIT_CATEGORY FOREIGN KEY (category) REFERENCES UNIT_CATEGORY(id)
);

-- DIFFICULTY
CREATE TABLE DIFFICULTY (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    label VARCHAR(255) NOT NULL
);

-- PROFILE
CREATE TABLE PROFILE (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email VARCHAR(255) NOT NULL,
    username VARCHAR(255) NOT NULL,
    password VARCHAR(255),
    invited_by INT,
    CONSTRAINT FK_USER_INVITED_BY FOREIGN KEY (invited_by) REFERENCES PROFILE(id)
);

-- CATEGORY
CREATE TABLE CATEGORY (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    label VARCHAR(255) NOT NULL
);

-- INGREDIENT
CREATE TABLE INGREDIENT (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    season INT NOT NULL
);

-- RECIPE
CREATE TABLE RECIPE (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    duration INT NOT NULL,
    serving INT NOT NULL,
    difficulty INT,
    created_by INT NOT NULL,
    CONSTRAINT FK_RECIPE_DIFFICULTY FOREIGN KEY (difficulty) REFERENCES DIFFICULTY(id),
    CONSTRAINT FK_RECIPE_CREATED_BY FOREIGN KEY (created_by) REFERENCES PROFILE(id)
);

-- RECIPE_INGREDIENT
CREATE TABLE RECIPE_INGREDIENT (
    recipe INT,
    ingredient INT,
    unit INT NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (recipe, ingredient),
    CONSTRAINT FK_RECIPE_INGREDIENT_RECIPE FOREIGN KEY (recipe) REFERENCES RECIPE(id),
    CONSTRAINT FK_RECIPE_INGREDIENT_INGREDIENT FOREIGN KEY (ingredient) REFERENCES INGREDIENT(id),
    CONSTRAINT FK_RECIPE_INGREDIENT_UNIT FOREIGN KEY (unit) REFERENCES UNIT(id)
);

-- RECIPE_CATEGORY
CREATE TABLE RECIPE_CATEGORY (
    recipe INT,
    category INT,
    PRIMARY KEY (recipe, category),
    CONSTRAINT FK_RECIPE_CATEGORY_RECIPE FOREIGN KEY (recipe) REFERENCES RECIPE(id),
    CONSTRAINT FK_RECIPE_CATEGORY_CATEGORY FOREIGN KEY (category) REFERENCES CATEGORY(id)
);

-- INVITATION
CREATE TABLE INVITATION (
    token UUID PRIMARY KEY,
    created_by INT NOT NULL,
    expiration TIMESTAMP NOT NULL,
    used BOOLEAN NOT NULL DEFAULT false,
    CONSTRAINT FK_INVITATION_CREATED_BY FOREIGN KEY (created_by) REFERENCES PROFILE(id)
);

-- FAVORI
CREATE TABLE FAVORI (
    profile INT,
    recipe INT,
    PRIMARY KEY (profile, recipe),
    CONSTRAINT FK_FAVORI_PROFILE FOREIGN KEY (profile) REFERENCES PROFILE(id),
    CONSTRAINT FK_FAVORI_RECIPE FOREIGN KEY (recipe) REFERENCES RECIPE(id)
);

-- STEP
CREATE TABLE STEP (
    recipe INT,
    position INT,
    content VARCHAR(255) NOT NULL,
    PRIMARY KEY (recipe, position),
    CONSTRAINT FK_STEP_RECIPE FOREIGN KEY (recipe) REFERENCES RECIPE(id)
);