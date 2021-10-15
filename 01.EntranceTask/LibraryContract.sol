pragma solidity ^0.8.0;

import "./Ownable.sol";

contract Library is Ownable {
	struct Book {
	    uint256 id;
		uint16 totalCopies;
		uint16 freeCopies;
		string name;
	}
	
	Book[] private books;
	
	
	//is it better to have these 2 collections in the Book entity itself?
	//is it efficient to have mapping inside another mapping?
	//how and when does the mappings/arrays get initialized?
	//mapping for borrowers - current
	mapping(uint256 => mapping(address => bool)) private currentBorrowers;
	//mapping for borrowers - all time/history
	mapping(uint256 => address[]) private allTimeBorrowers;
	
	function addBook(string calldata name, uint16 copiesCount) public onlyOwner returns(uint) {
		// do we care about duplicated names
		// check copies to be positive number
		require(copiesCount > 0, "copiesCount should be positive integer.");
		// create and add new book instance
		uint256 newBookId =  books.length;
		Book memory newBook = Book(newBookId,copiesCount, copiesCount, name);
		books.push(newBook);
		
		return newBookId;
	}
	
	function listAllBooks() public view returns(Book[] memory) {
		//what about paging? how big "responses" can we have?
		//filter out books with no freeCopies - or maybe have a paramater if we want to see them?
		
		// it is not ok to return the private storage of books to the public... maybe we need a view model here?
		return books;
	}
	
	function borrowBook(uint32 _bookId) public {
	    // what if there is no such book? indexOutOfRange exception?
	    Book storage book = books[_bookId];
	    
	    // check if there are free books to borrow
	    // better error message, add the actual book name and Id?
	    require(book.freeCopies > 0, "Can not borrow this book right now, there are no free copies.");
		
		// check if current user has borrowed this particular book
		require(currentBorrowers[_bookId][msg.sender] == false, "You have already borrowed this book.");
		
		//reduce the freeCopies counter and mark who borrowed the book
		book.freeCopies--;
		currentBorrowers[_bookId][msg.sender] = true;
		
		// what if a given user borrows a book for a second time? currently there will be an entry for every act of borrowing
		allTimeBorrowers[_bookId].push(msg.sender);
		
	}
	
	function returnBook(uint32 _bookId) public {
		// check if current user has borrowed this particular book
		require(currentBorrowers[_bookId][msg.sender] == true, "You havne't borrowed this book.");
		
		books[_bookId].freeCopies++;
		currentBorrowers[_bookId][msg.sender] = false;
	}
	
	function listAllTimeBorrowers(uint32 _bookId) public view returns(address[] memory) {
	    
	    return allTimeBorrowers[_bookId];
	}
}