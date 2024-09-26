import React from 'react';
import { useTable, useSortBy } from 'react-table';
import useFetchBooks from '../hooks/useBooks';
import { NavLink } from 'react-router-dom';
import { FaEdit, FaTrash, FaPlus } from 'react-icons/fa';

const BookList = () => {
  const { bookData, loading, error } = useFetchBooks();

  const columns = React.useMemo(
    () => [
      {
        Header: 'Cover',
        accessor: 'coverImage',
        // eslint-disable-next-line react/prop-types
        Cell: ({ value }) => (
          <img
            src={`http://localhost:10000/my_library/api/uploads/${value}`}
            alt="Book Cover"
            className="w-24 h-24 object-cover"
          />
        ),
      },
      {
        Header: 'Title',
        accessor: 'title',
      },
      {
        Header: 'Author',
        accessor: 'author',
        Cell: ({ value }) => value.name,
      },
      {
        Header: 'Publication Date',
        accessor: 'publicationDate',
        Cell: ({ value }) => new Date(value).toLocaleDateString(),
      },
      {
        Header: 'Actions',
        id: 'actions',
        // eslint-disable-next-line react/prop-types
        Cell: ({ row }) => (
          <div className="flex justify-end space-x-2">
            <button
              // eslint-disable-next-line react/prop-types
              onClick={() => handleEdit(row.original)}
              className="text-blue-950 px-2 py-1 rounded"
            >
            <FaEdit className="inline text-2xl mr-2" />  
            </button>
            <button
              // eslint-disable-next-line react/prop-types
              onClick={() => handleDelete(row.original._id)}
              className=" text-red-500 px-2 py-1 rounded"
            >
            <FaTrash className="inline text-2xl mr-2" />  
            </button>
          </div>
        ),
      },
    ],
    []
  );

  const data = React.useMemo(() => bookData || [], [bookData]);

  const {
    getTableProps,
    getTableBodyProps,
    headerGroups,
    rows,
    prepareRow,
  } = useTable({ columns, data }, useSortBy);

  const handleEdit = (book) => {
    console.log('Edit:', book);
    // Implement your edit functionality here
  };

  const handleDelete = (bookId) => {
    console.log('Delete:', bookId);
    // Implement your delete functionality here
  };


  if (loading) {
    return <p>Loading...</p>;
  }

  if (error) {
    return <p>Error: {error}</p>;
  }

  return (
    <div className="p-4">
      <div className="mb-4 flex justify-between items-center">
        <h1 className="text-2xl font-bold">Books</h1>
        <NavLink
          to="/add-book"
          className="blueBtn text-white px-4 py-2 rounded"
        >
        <FaPlus className="inline text-2xl mr-2" />
          Add Book</NavLink>
      </div>
      <div className="relative">
        <table {...getTableProps()} className="min-w-full bg-white border border-gray-200 rounded-lg shadow-md">
          <thead className="sticky top-0 bg-gray-100 z-10">
            {headerGroups.map(headerGroup => (
              <tr key={headerGroup.id} {...headerGroup.getHeaderGroupProps()}>
                {headerGroup.headers.map(column => (
                  <th
                    key={column.id}
                    {...column.getHeaderProps(column.getSortByToggleProps())}
                    className="px-4 py-2 border-b"
                  >
                    {column.render('Header')}
                    <span>
                      {column.isSorted
                        ? column.isSortedDesc
                          ? ' 🔽'
                          : ' 🔼'
                        : ''}
                    </span>
                  </th>
                ))}
              </tr>
            ))}
          </thead>
        </table>
        <div className="overflow-y-auto max-h-[calc(100vh-10rem)]">
          <table {...getTableProps()} className="min-w-full bg-white border border-gray-200 rounded-lg shadow-md">
            <tbody {...getTableBodyProps()}>
              {rows.map(row => {
                prepareRow(row);
                return (
                  <tr key={row.id} {...row.getRowProps()} className="border-b">
                    {row.cells.map(cell => (
                      <td key={cell.column.id} {...cell.getCellProps()} className="px-4 py-2">
                        {cell.render('Cell')}
                      </td>
                    ))}
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

export default BookList;
