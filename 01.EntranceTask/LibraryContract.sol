contract Library {
	struct Book {
		uint32 id,
		uint16 totalCopies,
		uint16 freeCopies,
		string name
	}
	
	Book[] books private;
	
	//mapping for borrowers - current
	//mapping for borrowers - all time/history
	
	function addBook(string calldata name, uint16 copiesCount) public onlyOwner {
		// do we care about duplicate names
		// check copies to be positive number
		// create and add new book instance
	}
	
	function listAllBooks() public view returns(Book[]) {
		//what about paging? how big "responses" can we have?
		//filter out books with no freeCopies - or maybe have a paramater do we want to see them?
		
	}
	
	function borrowBook(uint32 calldata _bookId) public {
		// check if current user has borrowed this particular book
		// check if there are free books to borrow
	}
	
	function returnBook(uint32 calldata _bookId) public {
		// check if current user has borrowed this particular book
	}
	
	function listBorrowers(uint32 calldata _bookId) public view returns(address[]) {
	}
}