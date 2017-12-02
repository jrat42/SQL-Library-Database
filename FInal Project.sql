CREATE DATABASE db_library
USE db_library
GO



CREATE TABLE tbl_publisher	 (
	 publisher_name VARCHAR(50) PRIMARY KEY NOT NULL, 
	 publisher_address VARCHAR(50) NOT NULL,
	 publisher_phone VARCHAR(50) NOT NULL
);


CREATE TABLE tbl_book (
	 book_id INT PRIMARY KEY NOT NULL IDENTITY (1,1),
	 book_title VARCHAR(50) NOT NULL,
	 book_publishername VARCHAR(50) NOT NULL CONSTRAINT fk_book_publishername FOREIGN KEY REFERENCES tbl_publisher(publisher_name) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE tbl_authors (
	 authors_id INT NOT NULL CONSTRAINT fk_book_bookid FOREIGN KEY REFERENCES tbl_book(book_id) ON UPDATE CASCADE ON DELETE CASCADE,
	 authors_authorname VARCHAR(50) NOT NULL
);

CREATE TABLE tbl_borrower (
	 borrower_id INT PRIMARY KEY NOT NULL IDENTITY (1,1),
	 borrower_name VARCHAR(50) NOT NULL,
	 borrower_address VARCHAR(50) NOT NULL,
	 borrower_phone VARCHAR(50) NOT NULL
);

CREATE TABLE tbl_branch (
	 branch_id INT PRIMARY KEY NOT NULL IDENTITY (1,1),
	 branch_name VARCHAR(50) NOT NULL,
	 branch_address VARCHAR(50) NOT NULL
);

CREATE TABLE tbl_copies (
	 copies_bookid INT NOT NULL CONSTRAINT fk_copies_bookid FOREIGN KEY REFERENCES tbl_book(book_id) ON UPDATE CASCADE ON DELETE CASCADE,
	 copies_branchid INT NOT NULL CONSTRAINT fk_branch_id FOREIGN KEY REFERENCES tbl_branch(branch_id) ON UPDATE CASCADE ON DELETE CASCADE,
	 copies_copynumber INT NOT NULL
);

CREATE TABLE tbl_loans (
	 loans_id INT NOT NULL CONSTRAINT fk_loans_bookid FOREIGN KEY REFERENCES tbl_book(book_id) ON UPDATE CASCADE ON DELETE CASCADE,
	 loans_branchid INT NOT NULL CONSTRAINT fk_loans_branchid FOREIGN KEY REFERENCES tbl_branch(branch_id) ON UPDATE CASCADE ON DELETE CASCADE,
	 loans_cardno INT NOT NULL CONSTRAINT fk_borrower_id FOREIGN KEY REFERENCES tbl_borrower(borrower_id) ON UPDATE CASCADE ON DELETE CASCADE,
	 loans_dateout VARCHAR(50) NOT NULL,
	 loans_duedate VARCHAR(50) NOT NULL
);

INSERT INTO tbl_publisher VALUES ('Random House', '123 Main St', '123-456-7890')

INSERT INTO tbl_book VALUES ('Jurrassic Park', 'Random House')

SELECT * FROM tbl_book

INSERT INTO tbl_branch VALUES ('Downtown', '123 Peach St.'), ('Riverside', '345 Side St')

SELECT * FROM tbl_branch

INSERT INTO tbl_authors VALUES (2, 'Stephen King'), (8, 'Roald Dahl'), (10, 'William Shakespeare'), (12, 'Agatha Christie'), (13, 'Tony Hillerman'), (14, 'JRR Tolkien'), (15, 'Brandon Sanderson'), (17, 'CS Lewis'), (21, 'JK Rowling'), (22,'Philip K Dick')

INSERT INTO tbl_book VALUES ('It',  'Random House'), ('The Dark Tower', 'Random House'), ('Carrie',  'Random House'), ('The Shining', 'Random House'), ('James and the Giant Peach', 'Random House'), ('Charlie and the Chocolate Factory', 'Random House'), ('The Tempest', 'Random House'), ('Macbeth', 'Random House'), ('Murder on the Orient Express', 'Random House'), ('Patrol', 'Random House'), ('The Return of the King', 'Random House'), ('The Way of Kings', 'Random House'), ('Words of Radiance', 'Random House'), ('The Silver Chair', 'Random House'), ('The Magicians Nephew', 'Random House'), ('Voyage of the Dawn Treader', 'Random House'), ('The Last Battle', 'Random House'), ('Harry Potter and the Deathly Hallows', 'Random House'), ('A Scanner Darkly', 'Random House'), ('Do Androids Dream of Electric Sheep?', 'Random House')

SELECT * FROM tbl_authors

INSERT INTO tbl_copies VALUES (11, 1, 2), (2, 3, 2), (3, 4, 2), (4, 1, 2), (5, 2, 2), (6, 1, 2), (7, 3, 2), (8, 4, 2), (9, 2, 2), (10, 1, 2)

SELECT * FROM tbl_copies

INSERT INTO tbl_borrower VALUES ('John Smith', '123 Blackbird St', '234-567-8901'), ('Mary Tyler', '234 BirdBlack St', '345-678-9012'), ('Tonald Drump', '345 Bluebird St', '456-789-0123'), ('Pablo Escobar', '567 Troubador St', '678-901-2345'), ('Susan White', '789 Google St', '789-012-3456'), ('Greg Black', '890 Frog St', '890-123-4567'), ('Tom Brown', '901 Fly St', '901-234-5678'), ('Jerry Green', '012 5th Ave', '012-345-5678')

SELECT * FROM tbl_borrower

INSERT INTO tbl_loans VALUES (2, 2, 4, '11/25/17', '12/22/17'), (3, 2, 4, '11/25/17', '12/22/17'), (4, 2, 4, '11/25/17', '12/22/17'), (5, 2, 4, '11/25/17', '12/22/17'), (6, 2, 4, '11/25/17', '12/22/17'), (7, 1, 7, '11/25/17', '12/22/17'), (8, 1, 7, '11/25/17', '12/22/17'),(9, 1, 7, '11/25/17', '12/22/17'),(10, 1, 7, '11/25/17', '12/22/17'),(11, 1, 7, '11/25/17', '12/22/17'),(12, 3, 1, '11/25/17', '12/22/17'),(13, 2, 2, '11/25/17', '12/22/17'),(14, 3, 3, '11/25/17', '12/22/17'),(15, 4, 5, '11/25/17', '12/22/17'),(16, 1, 6, '11/25/17', '12/22/17'),(17, 3, 8, '11/25/17', '12/22/17'),(18, 1, 7, '11/25/17', '12/22/17'),(19, 1, 7, '11/25/17', '12/22/17'),(20, 1, 7, '11/25/17', '12/22/17'),(21, 1, 7, '11/25/17', '12/22/17'),(22, 1, 7, '11/25/17', '12/22/17'),(23, 1, 7, '11/25/17', '12/22/17')

SELECT * FROM tbl_loans

--Question #1 finding number of copies lost tribe at sharpstown branch
CREATE PROC copies_losttribe
AS
SELECT C.copies_copynumber
FROM tbl_book AS B
JOIN tbl_copies AS C ON B.book_id = C.copies_bookid
JOIN tbl_branch AS BR ON C.copies_branchid = BR.branch_id
WHERE B.book_id = 2 AND BR.branch_id = 1
GO
--Question #2 How many copies lost tribe at each branch
CREATE PROC losttribe_branch
AS
SELECT BR.branch_name, B.book_title, C.copies_copynumber
FROM tbl_book AS B
LEFT OUTER JOIN tbl_copies AS C ON B.book_id = C.copies_bookid
LEFT OUTER JOIN tbl_branch AS BR ON C.copies_branchid = BR.branch_id
WHERE B.book_title = 'the lost tribe'
GO
--Question #3 Names of all borrowers who do not have books checked out
CREATE PROC names_checkedout
AS
SELECT BO.borrower_name
FROM tbl_borrower AS BO
JOIN tbl_loans AS L ON L.loans_cardno = BO.borrower_id
WHERE loans_id IS NULL
GO
--Question #4 For each book that is loaned out from the "Sharpstown" branch and whose
--DueDate is today, retrieve the book title, the borrower's name, and the borrower's address.
CREATE PROC sharpstown_borrower
AS
SELECT BO.borrower_name, BO.borrower_address, B.book_title
FROM tbl_book AS B
JOIN tbl_loans AS L ON L.loans_id = B.book_id
JOIN tbl_branch AS BR ON L.loans_branchid = BR.branch_id
JOIN tbl_borrower AS BO ON BO.borrower_id = L.loans_cardno
WHERE BR.branch_name = 'Sharpstown' AND L.loans_duedate = '11/25/17'
GO
--Question #5 For each library branch, retrieve the branch name 
--and the total number of books loaned out from that branch.
CREATE PROC branch_booknumber
AS
SELECT BR.branch_name, COUNT (C.copies_copynumber)
FROM tbl_branch AS BR
JOIN tbl_copies AS C ON BR.branch_id = C.copies_branchid
GROUP BY BR.branch_name
GO
--Question #6 Retrieve the names, addresses, and number of books checked 
--out for all borrowers who have more than five books checked out.
CREATE PROC retrieve_five
AS
SELECT BO.borrower_name, BO.borrower_address, COUNT (L.loans_id)
FROM tbl_borrower AS BO
JOIN tbl_loans AS L ON L.loans_cardno = BO.borrower_id
GROUP BY BO.borrower_name, BO.borrower_address
HAVING COUNT (L.loans_id) > 5
GO
--Question #7  For each book authored (or co-authored) by "Stephen King", 
--retrieve the title and the number of copies owned by the library branch whose name is "Central".
CREATE PROC king_central
AS
SELECT B.book_title, C.copies_copynumber
FROM tbl_book AS B
JOIN tbl_copies AS C ON C.copies_bookid = B.book_id
JOIN tbl_authors AS A ON A.authors_id = B.book_id
JOIN tbl_branch AS BR ON BR.branch_id = C.copies_branchid
WHERE authors_authorname = 'Stephen King' AND BR.branch_name = 'Central'
GO