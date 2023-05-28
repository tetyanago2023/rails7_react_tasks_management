import React, { useEffect, useState } from 'react';
import { useNavigate, Link } from "react-router-dom";
import { loginStatus } from "../helpers/login";
import { logout } from "../queries/Sessions";

const ProtectedRoute = ({ children }) => {
    const [currentUser, setCurrentUser] = useState({});
    const navigate = useNavigate();

    useEffect(() => {
        (async () => {
            const { isLoggedIn, user } = await loginStatus();
            if(!isLoggedIn) {
                navigate("/login");
            }
            setCurrentUser(user)
        })();
    }, []);


    return <>
        <div style={{float: 'right'}}>
            <h6>Logged as {currentUser.name} - {currentUser.type}</h6>
            <Link to={'/'}
                  onClick={() => logout(() => navigate('/'))}
                  className="btn btn-sm custom-button"
                  role="button">Logout</Link>
        </div>

        {React.cloneElement(children, { currentUser: currentUser })}
    </>
};

export default ProtectedRoute;