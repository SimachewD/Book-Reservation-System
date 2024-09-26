import { AuthContext } from "../context/AuthContext";
import { useAuthContext } from "./useAuth";


export const useLogout = () => {

    const { dispatch } = useAuthContext(AuthContext);

    const logout = ()=>{
        //remove user from local storage
        localStorage.removeItem('user');

        console.log('User Logged out');

        //dispatch logout action
        dispatch({type: 'LOGOUT'});
    }

    return {logout};
}