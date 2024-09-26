import { useState } from 'react';
import { NavLink } from 'react-router-dom';
import { FaTachometerAlt, FaPlus, FaBook, FaUsers, FaUserEdit, FaAngleDown, FaAngleUp, FaEnvelope, FaCalendarCheck, FaReceipt, FaClock, FaHeart } from 'react-icons/fa';

const Sidebar = () => {
  const [isBooksExpanded, setIsBooksExpanded] = useState(false);

  const toggleBooksMenu = () => {
    setIsBooksExpanded(!isBooksExpanded);
  };

  return (
    <div className="w-64 text-white blueBtn">
      <div className="p-6 text-2xl font-bold">Admin Panel</div>
      <nav className='mt-6 mx-auto w-fit'>
        <NavLink
          to="/"
          className="block py-2.5 px-4 hover:underline transition duration-200"
        >
          <FaTachometerAlt className="inline text-3xl mr-2 mb-2" /><p className='text-gray-300 text-lg font-bold inline'>Dashboard</p>
        </NavLink>
        <NavLink
          to="/add-book"
          className="block py-2.5 px-4 hover:underline transition duration-200"
        >
          <FaPlus className="inline text-2xl mr-2" /> <p className='text-gray-300 text-lg font-bold inline'>Add Book</p>
        </NavLink>
        <NavLink
          to="/manage-books"
          className="block py-2.5 px-4 hover:underline transition duration-200"
        >
          <FaBook className="inline text-2xl mr-2" /> <p className='text-gray-300 text-lg font-bold inline'>Manage Books</p>
        </NavLink>
        <div className="py-2.5 px-4 cursor-pointer hover:underline transition duration-200" onClick={toggleBooksMenu} >
          <FaEnvelope className="inline text-2xl mr-2" /> 
          <p className='text-gray-300 text-lg font-bold inline'>User Requests</p>
          {isBooksExpanded ? <FaAngleUp className="inline ml-2" /> : <FaAngleDown className="inline ml-2" />}
        </div>
        {isBooksExpanded && (
          <div className="ml-6">
            <NavLink to="/pending-books" className="block py-2.5 px-4 hover:underline transition duration-200">
            <FaClock className="inline text-2xl mr-2" />
              <p className='inline'>Pending Books</p>
            </NavLink>
            <NavLink to="/reserved-books" className="block py-2.5 px-4 hover:underline transition duration-200">
            <FaCalendarCheck className="inline text-2xl mr-2" />
              <p className='inline'>Reserved Books</p>
            </NavLink>
            <NavLink to="/purchased-books" className="block py-2.5 px-4 hover:underline transition duration-200">
            <FaReceipt className="inline text-2xl mr-2" />
             <p className='inline'>Purchased Books</p>
            </NavLink>
            <NavLink to="/favorite-books" className="block py-2.5 px-4 hover:underline transition duration-200">
            <FaHeart className="inline text-2xl mr-2" />
             <p className='inline'>Favorite Books</p>
            </NavLink>
          </div>
        )}
        <NavLink
          to="/manage-users"
          className="block py-2.5 px-4 hover:underline transition duration-200"
        >
          <FaUsers className="inline text-2xl mr-2" /> <p className='text-gray-300 text-lg font-bold inline'>Manage Users</p>
        </NavLink>
        <NavLink
          to="/manage-authors"
          className="block py-2.5 px-4 hover:underline transition duration-200"
        >
          <FaUserEdit className="inline text-2xl mr-2" /> <p className='text-gray-300 text-lg font-bold inline'>Manage Authors</p>
        </NavLink>
      </nav>
    </div>
  );
};

export default Sidebar;
