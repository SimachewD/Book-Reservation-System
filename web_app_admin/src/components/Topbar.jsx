
import { FaUserCircle } from 'react-icons/fa';
import { useLogout } from '../hooks/useLogout';

const Topbar = () => {
  const { logout } = useLogout();

    const handleClick = ()=>{
      logout();
    }
  return (
    <header className="flex items-center justify-between p-4 bg-gray-200 shadow-md">
      <div className="text-xl font-semibold">Book Reservation System</div>
      <div className="flex items-center space-x-4">
        <span>Admin</span>
        <FaUserCircle size={30} onClick={handleClick} />
      </div>
    </header>
  );
};

export default Topbar;
