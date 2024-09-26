import useFetchBooks from "../hooks/useBooks";
import useFetchUsers from "../hooks/useUsers";


const Dashboard = () => {
  const { data } = useFetchUsers();
  const { bookData } = useFetchBooks();

  return (
  <div className="flex flex-col h-screen bg-gray-100">
    <div className="flex-1 flex flex-col">
      <main className="flex-1 p-6 bg-white">
        <h1 className="text-3xl font-bold text-gray-800 mb-6">Dashboard</h1>
        <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-6">
          <div className="bg-white text-gray-800 p-6 rounded-lg shadow-lg border border-gray-200">
            <h2 className="text-xl font-semibold mb-4">Total Books</h2>
            <p className="text-3xl font-bold">{bookData.length}</p>
          </div>
          <div className="bg-white text-gray-800 p-6 rounded-lg shadow-lg border border-gray-200">
            <h2 className="text-xl font-semibold mb-4">Total Users</h2>
            <p className="text-3xl font-bold">{data.length}</p>
          </div>
          <div className="bg-white text-gray-800 p-6 rounded-lg shadow-lg border border-gray-200">
            <h2 className="text-xl font-semibold mb-4">Total Authors</h2>
            <p className="text-3xl font-bold">12</p>
          </div>
          <div className="bg-white text-gray-800 p-6 rounded-lg shadow-lg border border-gray-200">
            <h2 className="text-xl font-semibold mb-4">Books Reserved</h2>
            <p className="text-3xl font-bold">10</p>
          </div>
          <div className="bg-white text-gray-800 p-6 rounded-lg shadow-lg border border-gray-200">
            <h2 className="text-xl font-semibold mb-4">Books Pending</h2>
            <p className="text-3xl font-bold">5</p>
          </div>
          <div className="bg-white text-gray-800 p-6 rounded-lg shadow-lg border border-gray-200">
            <h2 className="text-xl font-semibold mb-4">Books Purchased</h2>
            <p className="text-3xl font-bold">18</p>
          </div>
          <div className="bg-white text-gray-800 p-6 rounded-lg shadow-lg border border-gray-200">
            <h2 className="text-xl font-semibold mb-4">Books Favorite</h2>
            <p className="text-3xl font-bold">22</p>
          </div>
          <div className="bg-white text-gray-800 p-6 rounded-lg shadow-lg border border-gray-200">
            <h2 className="text-xl font-semibold mb-4"> Rejected Requests</h2>
            <p className="text-3xl font-bold">2</p>
          </div>
          {/* <div className="bg-white text-gray-800 p-6 rounded-lg shadow-lg border border-gray-200">
            <h2 className="text-xl font-semibold mb-4">Books Reserved</h2>
            <p className="text-3xl font-bold">0</p>
          </div> */}
          <div className="bg-white text-gray-800 p-6 rounded-lg shadow-lg col-span-1 sm:col-span-2 lg:col-span-3 border border-gray-200">
            <h2 className="text-xl font-semibold mb-4">Recent Activities</h2>
            <ul className="space-y-4">
              <li className="bg-gray-100 text-gray-800 p-4 rounded-lg shadow-md">User John Doe checked out <span className="text-gray-500 text-sm">2 hours ago</span></li>
              <li className="bg-gray-100 text-gray-800 p-4 rounded-lg shadow-md">User Jane Smith returned  <span className="text-gray-500 text-sm">1 day ago</span></li>
              <li className="bg-gray-100 text-gray-800 p-4 rounded-lg shadow-md">New book  added to collection <span className="text-gray-500 text-sm">3 days ago</span></li>
            </ul>
          </div>
        </div>
      </main>
    </div>
  </div>
);
}
export default Dashboard;
