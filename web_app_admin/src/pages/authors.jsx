import useFetchAuthors from '../hooks/useFetchAuthors';
import { FaEdit, FaTrashAlt } from 'react-icons/fa';

const Authors = () => {
  const { authorData, loading, error } = useFetchAuthors();

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error loading data: {error.message}</p>;

  const handleEdit = (id) => {
    // Handle edit logic
    console.log(`Edit author with ID: ${id}`);
  };

  const handleDelete = (id) => {
    // Handle delete logic
    console.log(`Delete author with ID: ${id}`);
  };

  return (
    <div>
      <h1>Manage Authors</h1>
      <ul>
        {authorData.map(author => (
          <li key={author.id} className="flex justify-between items-center py-2">
            <div>{author.name}</div>
            <div className="flex space-x-2">
              <button onClick={() => handleEdit(author.id)} className="text-blue-500">
                <FaEdit />
              </button>
              <button onClick={() => handleDelete(author.id)} className="text-red-500">
                <FaTrashAlt />
              </button>
            </div>
          </li>
        ))}
      </ul>
    </div>
  );
};

export default Authors;
