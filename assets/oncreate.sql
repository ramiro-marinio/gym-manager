CREATE TABLE ExerciseContainers (
    Id INTEGER PRIMARY KEY,
    Name VARCHAR(200) ,
    Description VARCHAR(5000),
    CreationDate DATE,
    IsRoutine BOOLEAN DEFAULT 1,
    Parent INTEGER,
    Sets INTEGER,
    RoutineOrder INTEGER,
    FOREIGN KEY (Parent) REFERENCES ExerciseContainers(Id) ON DELETE CASCADE
);
CREATE TABLE ExerciseTypes (
    Id INTEGER PRIMARY KEY,
    Name VARCHAR(200) NOT NULL,
    Description VARCHAR(2000),
    RepUnit BOOLEAN DEFAULT 1
);
CREATE TABLE Exercises (
    Id INTEGER PRIMARY KEY,
    ExerciseType INTEGER NOT NULL,
    Amount INTEGER NOT NULL,
    Sets INTEGER NOT NULL,
    RoutineOrder INTEGER NOT NULL,
    Dropset BOOLEAN DEFAULT 0,
    Supersetted BOOLEAN DEFAULT 0,
    Parent INTEGER NOT NULL,
    FOREIGN KEY (ExerciseType) REFERENCES ExerciseTypes(Id) ON DELETE SET NULL,
    FOREIGN KEY (Parent) REFERENCES ExerciseContainers(Id) ON DELETE SET NULL
);
CREATE TABLE SetRecords(
    Id INTEGER PRIMARY KEY,
    ExerciseType INTEGER NOT NULL,
    RoutineId INTEGER NOT NULL,
    RecordId INTEGER NOT NULL,
    Amount INTEGER NOT NULL,
    Weight INTEGER,
    FOREIGN KEY (ExerciseType) REFERENCES ExerciseTypes(Id) ON DELETE CASCADE,
    FOREIGN KEY (RecordId) REFERENCES RoutineRecords(Id) ON DELETE CASCADE,
    FOREIGN KEY (RoutineId) REFERENCES ExerciseContainers(Id) ON DELETE CASCADE
);