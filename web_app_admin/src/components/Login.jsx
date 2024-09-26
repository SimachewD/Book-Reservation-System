import { useState } from "react";
import { useLogin } from "../hooks/useLogin";

const Login = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const { login, isLoading, error } = useLogin();

    const handleSubmit = async (e) => {
        e.preventDefault();
        await login(email, password);
        setEmail('');
        setPassword('');
    }

    return (
        <form onSubmit={handleSubmit} className=" max-w-md mx-auto mt-32 p-4 bg-white shadow-md rounded">
            <h3 className="text-2xl font-bold mb-4">Admin Log In</h3>

            <div className="mb-4">
                <label htmlFor="email" className="block text-gray-700">E-mail:</label>
                <input
                    id="email"
                    type="text"
                    required
                    className="mt-1 block h-10 w-full rounded border-gray-300 border-2 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                    onChange={(e) => setEmail(e.target.value)}
                    value={email}
                />
            </div>

            <div className="mb-4">
                <label htmlFor="password" className="block text-gray-700">Password:</label>
                <input
                    id="password"
                    type="password"
                    required
                    className="mt-1 block h-10 w-full rounded border-gray-300 border-2 shadow-sm focus:border-indigo-300 focus:ring focus:ring-indigo-200 focus:ring-opacity-50"
                    onChange={(e) => setPassword(e.target.value)}
                    value={password}
                />
            </div>

            <button disabled={isLoading} className="bg-indigo-500 text-white font-semibold py-2 px-4 rounded disabled:bg-gray-400 disabled:cursor-not-allowed">Login</button>
            {error && <div className="text-red-500 mt-2">{error}</div>}
        </form>
    );
}

export default Login;
