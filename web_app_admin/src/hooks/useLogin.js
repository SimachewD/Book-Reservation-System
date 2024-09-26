import { useState } from "react";
import { useAuthContext } from "./useAuth";

    
export const useLogin = () => {

    const { dispatch } = useAuthContext();

    const [ error, setErrors] = useState(null);
    const [ isLoading, setIsLoading] = useState(null);

    const login = async ( email, password )=>{

        setIsLoading(true);
        setErrors(null); 

        const response = await fetch('http://localhost:10000/my_library/api/admin/login',{
                method: 'POST',
                body: JSON.stringify({email, password}),
                headers: {'Content-Type': 'application/json'}
            });

        const json = await response.json();
        if (response.ok) {
            localStorage.setItem('user', JSON.stringify(json)); // save the user to local storage to keep logged in
            dispatch({type: 'LOGIN', payload: json});//updating global state (user status) to re-render a DOM
            setIsLoading(false);
        } else {
            setIsLoading(false);
            setErrors(json.Error);
        }
    }

    return { login, isLoading, error };
}
