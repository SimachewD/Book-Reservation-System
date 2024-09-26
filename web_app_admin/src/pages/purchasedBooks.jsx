import useFetchBooks from '../hooks/useFetchBooks';
import { FaEdit, FaTrashAlt } from 'react-icons/fa';

const PurchasedBooks = () => {
  const { bookData, loading, error } = useFetchBooks('purchased');

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error loading data: {error.message}</p>;

  const handleEdit = (id) => {
    // Handle edit logic
    console.log(`Edit book with ID: ${id}`);
  };

  const handleDelete = (id) => {
    // Handle delete logic
    console.log(`Delete book with ID: ${id}`);
  };

  return (
    <div>
      <h1>Purchased Books</h1>
      <ul>
        {bookData.map(book => (
          <li key={book.id} className="flex justify-between items-center py-2">
            <div>{book.title} by {book.author}</div>
            <div className="flex space-x-2">
              <button onClick={() => handleEdit(book.id)} className="text-blue-500">
                <FaEdit />
              </button>
              <button onClick={() => handleDelete(book.id)} className="text-red-500">
                <FaTrashAlt />
              </button>
            </div>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default PurchasedBooks;
