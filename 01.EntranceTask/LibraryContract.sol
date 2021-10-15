pragma solidity ^0.8.0;

import "./Ownable.sol";

contract Library is Ownable {
	struct Book {
	    uint32 id;
		uint16 totalCopies;
		uint16 freeCopies;
		string name;
	}
	
	Book[] private books;
	
	//mapping for borrowers - current
	//mapping for borrowers - all time/history
	
	function addBook(string calldata name, uint16 copiesCount) public onlyOwner returns(uint) {
		// do we care about duplicate names
		// check copies to be positive number
		require(copiesCount > 0, "copiesCounts should be positive integer.");
		// create and add new book instance
		uint32 newBookId =  uint32(books.length);
		Book memory newBook = Book(newBookId,copiesCount, copiesCount, name);
		books.push(newBook);
		
		return newBookId;
	}
	
	function listAllBooks() public view returns(Book[] memory) {
		//what about paging? how big "responses" can we have?
		//filter out books with no freeCopies - or maybe have a paramater do we want to see them?
		
		// it is not ok to return the private storage of books to the public... we need a view model here?
		return books;
	}
	
	function borrowBook(uint32 _bookId) public {
		// check if current user has borrowed this particular book
		// check if there are free books to borrow
	}
	
	function returnBook(uint32 _bookId) public {
		// check if current user has borrowed this particular book
	}
	
	function listBorrowers(uint32 _bookId) public view returns(address[] memory) {
	}
}