import React, { useState } from 'react';
import { FaCheck, FaTimes, FaChevronDown, FaChevronUp } from 'react-icons/fa';
import useFetchUserBooks from '../hooks/useUserBooks';

const PendingBooks = () => {
  const { UserBookData, loading, error } = useFetchUserBooks();
  const [expanded, setExpanded] = useState(null); // State to track expanded rows

  if (loading) return <p>Loading...</p>;
  if (error) return <p>Error loading data: {error.message}</p>;

  const handleApprove = (id) => {
    console.log(`Approve reservation with ID: ${id}`);
  };

  const handleReject = (id) => {
    console.log(`Reject reservation with ID: ${id}`);
  };

  const toggleExpand = (id) => {
    setExpanded(expanded === id ? null : id); // Toggle expand/collapse
  };

  return (
    <div className="container mx-auto px-4 py-6">
      <h1 className="text-2xl font-bold mb-6">Pending Reservations</h1>
      <table className="min-w-full table-auto bg-white shadow-md rounded-md">
        <thead>
          <tr className="bg-gray-200">
            <th className="py-3 px-6 text-left">Book Title</th>
            <th className="py-3 px-6 text-left">User ID</th>
            <th className="py-3 px-6 text-left">Status</th>
            <th className="py-3 px-6 text-center">Actions</th>
            <th className="py-3 px-6 text-center">Details</th>
          </tr>
        </thead>
        <tbody>
          {UserBookData && UserBookData.map((reservation) => (
            <React.Fragment key={reservation._id}>
              <tr className="border-b">
                <td className="py-3 px-6">{reservation.book ? reservation.book.title : 'No Book Assigned'}</td>
                <td className="py-3 px-6">{reservation.user}</td>
                <td className="py-3 px-6">{reservation.status}</td>
                <td className="py-3 px-6 text-center">
                  <button onClick={() => handleApprove(reservation._id)} className="text-green-500 mx-2">
                    <FaCheck />
                  </button>
                  <button onClick={() => handleReject(reservation._id)} className="text-red-500 mx-2">
                    <FaTimes />
                  </button>
                </td>
                <td className="py-3 px-6 text-center">
                  <button onClick={() => toggleExpand(reservation._id)} className="text-blue-500">
                    {expanded === reservation._id ? <FaChevronUp /> : <FaChevronDown />}
                  </button>
                </td>
              </tr>
              {expanded === reservation._id && (
                <tr className="bg-gray-100">
                  <td colSpan="5" className="py-3 px-6">
                    <div className="grid grid-cols-2 gap-4">
                      <div>
                        <p><b>Due Date:</b> {new Date(reservation.dueDate).toLocaleDateString()}</p>
                        <p><b>Reserved Date:</b> {new Date(reservation.reservedDate).toLocaleDateString()}</p>
                      </div>
                      {reservation.book && (
                        <div>
                          <p><b>Author ID:</b> {reservation.book.author}</p>
                          <p><b>Publication Date:</b> {new Date(reservation.book.publicationDate).toLocaleDateString()}</p>
                          <img 
                            src={`/${reservation.book.coverImage}`} 
                            alt={reservation.book.title} 
                            className="w-32 h-48 object-cover mt-2"
                          />
                        </div>
                      )}
                    </div>
                  </td>
                </tr>
              )}
            </React.Fragment>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default PendingBooks;
