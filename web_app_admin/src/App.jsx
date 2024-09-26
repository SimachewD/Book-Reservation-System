// import { Route, createBrowserRouter, createRoutesFromElements, RouterProvider, Navigate } from 'react-router-dom';

// import NotFound from './NotFound';
// import HomePage from './pages';
// import Books from './pages/books';
// import Users from './pages/users';
// import { useAuthContext } from './hooks/useAuth';
// import Login from './components/Login';
// import Sidebar from './components/Sidebar';
// import ReservedBooks from './pages/reservedBooks';

// function App() {
//   const { user } = useAuthContext();

//   const router = createBrowserRouter(
//     createRoutesFromElements(
//       <Route>
//         <Route path='/' element = { user ? <Sidebar />:null}>
//             <Route index element={ user ? <HomePage />:<Login />} />
//             <Route path='login' element = { !user ? <Login />:<Navigate to={'../home'} />} /> 
//             <Route path='home' element={ user ? <HomePage />:<Login />} />
//             <Route path='books' element={ user ? <Books />:<Navigate to={'../login'} /> } />
//             <Route path='reservedbooks' element={ user ? <ReservedBooks />:<Navigate to={'../login'} /> } />
//             <Route path='users' element={ user ? <Users />:<Navigate to={'../login'} />} />
//         </Route>
//         <Route path='*' element = { <NotFound /> } />    
//       </Route>
//     )
//   );

//   return (
//     <RouterProvider router={router} />
//   );
// }

// export default App;


import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import Sidebar from './components/Sidebar';
import Topbar from './components/Topbar';
import Dashboard from './pages/index';
import AddBook from './components/BookForm';
import ManageBooks from './pages/books';
import ManageUsers from './pages/users';
import { useAuthContext } from './hooks/useAuth';
import Login from './components/Login';
import PendingBooks from './pages/pendingBooks';
// import ManageAuthors from './pages/ManageAuthors';

function App() {
  const { user } = useAuthContext();
  return (
    <div className="flex h-screen bg-gray-100">
      <Router>
        <Sidebar />
        <div className="flex flex-col flex-1">
          <Topbar />
          <main className="flex-1 p-6 overflow-y-auto">
            <Routes>
              <Route path="/" element={user?<Dashboard />:<Login />} />
              <Route path="/add-book" element={user?<AddBook />:<Login />} />
              <Route path="/manage-books" element={user?<ManageBooks />:<Login />} />
              <Route path="/manage-users" element={user?<ManageUsers />:<Login />} />
              <Route path="/pending-books" element={user?<PendingBooks />:<Login />} />
              <Route path="/manage-users" element={user?<ManageUsers />:<Login />} />
              <Route path="/manage-users" element={user?<ManageUsers />:<Login />} />
              {/* <Route path="/manage-authors" element={<ManageAuthors />} /> */}
            </Routes>
          </main>
        </div>
      </Router>
    </div>
  );
}

export default App;
