import { createContext, useReducer, useEffect } from 'react';
import { AuthReducer } from '../reducer/AuthReducer';

export const AuthContext = createContext();

export const AuthContextProvider = ({ children }) => {
    const [state, dispatch] = useReducer(AuthReducer, { user: null });

    useEffect(() => {
        const user = localStorage.getItem('user');
        if (user) {
            try {
                const parsedUser = JSON.parse(user);
                dispatch({ type: 'LOGIN', payload: parsedUser });
            } catch (e) {
                console.error('Failed to parse user data from localStorage:', e);
            }
        }
    }, []);

    return (
        <AuthContext.Provider value={{ ...state, dispatch }}>
            {children}
        </AuthContext.Provider>
    );
};
