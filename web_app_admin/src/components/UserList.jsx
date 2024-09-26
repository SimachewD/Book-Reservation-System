import React from 'react';
import { useTable, useSortBy } from 'react-table';
import useFetchUsers from '../hooks/useUsers';
import { FaTrash } from 'react-icons/fa';

const UserList = () => {
  const { data, loading, error } = useFetchUsers();

  const columns = React.useMemo(
    () => [
      {
        Header: 'Email',
        accessor: 'email',
      },
      {
        Header: 'Phone Number',
        accessor: 'phone',
      },
      {
        Header: 'Actions',
        id: 'actions',
        // eslint-disable-next-line react/prop-types
        Cell: ({ row }) => (
          <div className="flex justify-end space-x-2">
            <button
              // eslint-disable-next-line react/prop-types
              onClick={() => handleDelete(row.original.id)}
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

  const dataTable = React.useMemo(() => data || [], [data]);

  const {
    getTableProps,
    getTableBodyProps,
    headerGroups,
    rows,
    prepareRow,
  } = useTable({ columns, data: dataTable }, useSortBy);

  const handleDelete = (userId) => {
    console.log('Delete:', userId);
    // Implement your delete functionality here
  };

  if (loading) {
    return <p className='text-lg ml-72 mt-48'>Loading...</p>;
  }

  if (data.length === 0) {
    return <p className='text-red-500 text-lg ml-72 mt-48'>No users registered yet</p>;
  }

  if (error) {
    return <p className='text-red-500 text-lg ml-72 mt-48'>Error: {error}</p>;
  }

  return (
    <div className="p-4">
      <div className="mb-4 flex justify-between items-center">
        <h1 className="text-2xl font-bold">Users</h1>
      </div>
      <div className="relative">
        <table {...getTableProps()} className="min-w-full bg-white border border-gray-200 rounded-lg shadow-md">
          <thead className="sticky top-0 bg-gray-100 z-10">
            {headerGroups.map(headerGroup => (
              <tr key={headerGroup.id} {...headerGroup.getHeaderGroupProps()} className='flex justify-between items-start'>
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
                  <tr key={row.id} {...row.getRowProps()} className="border-b flex justify-between items-start">
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

export default UserList;
