CREATE TABLE ExerciseContainers (
    Id INT AUTO_INCREMENT,
    Name VARCHAR(200) NOT NULL,
    Description VARCHAR(5000),
    CreationDate DATE,
    IsRoutine BOOLEAN DEFAULT 1,
    Parent INT,
    Sets INT,
    PRIMARY KEY (Id),
    FOREIGN KEY (Parent) REFERENCES ExerciseContainers(Id) ON DELETE CASCADE
);
CREATE TABLE ExerciseTypes (
    Id INT AUTO_INCREMENT,
    Name VARCHAR(200) NOT NULL,
    Description VARCHAR(2000),
    RepUnit BOOLEAN DEFAULT 1,
    PRIMARY KEY (Id)
);
CREATE TABLE Exercises (
    Id INT AUTO_INCREMENT,
    ExerciseType INT NOT NULL,
    Amount INT NOT NULL,
    Sets INT NOT NULL,
    RoutineOrder INT NOT NULL,
    Dropset BOOLEAN DEFAULT 0,
    Supersetted BOOLEAN DEFAULT 0,
    Parent INT NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (ExerciseType) REFERENCES ExerciseTypes(Id) ON DELETE CASCADE,
    FOREIGN KEY (Parent) REFERENCES ExerciseContainers(Id) ON DELETE CASCADE
);
CREATE TABLE RoutineRecords (
    Id INT AUTO_INCREMENT,
    Moment DATETIME NOT NULL,
    RoutineId INT NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (RoutineId) REFERENCES ExerciseContainers(Id)
);
CREATE TABLE ExerciseRecords(
    Id INT AUTO_INCREMENT,
    ExerciseType INT NOT NULL,
    RecordId INT NOT NULL,
    Amount INT NOT NULL,
    Sets INT NOT NULL,
    PRIMARY KEY (Id),
    FOREIGN KEY (ExerciseType) REFERENCES ExerciseTypes(Id) ON DELETE CASCADE,
    FOREIGN KEY (RecordId) REFERENCES RoutineRecords(Id) ON DELETE CASCADE
);