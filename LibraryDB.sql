-- Create the Library Database
CREATE DATABASE LibraryDB;
USE LibraryDB;

-- Books Table
CREATE TABLE Books (
    bookID INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    author VARCHAR(100) NOT NULL,
    genre VARCHAR(50),
    publishedYear YEAR,
    ISBN VARCHAR(13) UNIQUE NOT NULL
);

-- Members Table
CREATE TABLE Members (
    memberID INT AUTO_INCREMENT PRIMARY KEY,
    fullName VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE,
    joinDate DATE NOT NULL
);

-- Loans Table (Many-to-Many relationship between Books and Members)
CREATE TABLE Loans (
    loanID INT AUTO_INCREMENT PRIMARY KEY,
    bookID INT NOT NULL,
    memberID INT NOT NULL,
    loanDate DATE NOT NULL,
    returnDate DATE,
    status ENUM('Borrowed', 'Returned') DEFAULT 'Borrowed',
    FOREIGN KEY (bookID) REFERENCES Books(bookID) ON DELETE CASCADE,
    FOREIGN KEY (memberID) REFERENCES Members(memberID) ON DELETE CASCADE
);

-- Librarians Table
CREATE TABLE Librarians (
    librarianID INT AUTO_INCREMENT PRIMARY KEY,
    fullName VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15) UNIQUE,
    hireDate DATE NOT NULL
);

-- Transactions Table (One-to-Many relationship with Loans)
CREATE TABLE Transactions (
    transactionID INT AUTO_INCREMENT PRIMARY KEY,
    loanID INT NOT NULL,
    transactionDate DATE NOT NULL,
    action ENUM('Issue', 'Return') NOT NULL,
    librarianID INT NOT NULL,
    FOREIGN KEY (loanID) REFERENCES Loans(loanID) ON DELETE CASCADE,
    FOREIGN KEY (librarianID) REFERENCES Librarians(librarianID) ON DELETE SET NULL
);
