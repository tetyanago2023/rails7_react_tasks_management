import React, { useEffect, useState } from 'react';
import { useNavigate } from "react-router-dom";
import { loginStatus } from "../helpers/login";
import { login } from "../queries/Sessions";

const Login = () => {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [errors, setErrors] = useState('');
    const navigate = useNavigate();

    useEffect(() => {
        (async () => {
            const { isLoggedIn } = await loginStatus();
            if(isLoggedIn) {
                navigate("/projects");
            }
        })();
    }, []);

    const loginCallback = () => {
        navigate("/projects");
    }

    const loginErrorCallback = (errors) => {
        setErrors(errors)
    }



    const handleSubmit = async (event) => {
        event.preventDefault();
        const user = { email, password };
        await login(user, loginCallback, loginErrorCallback);
    }

    return (
        <div>
            <h1>Log In</h1>
            {errors}
            <form onSubmit={handleSubmit}>
                <div className={"mb-3"}>
                    <input
                        placeholder="email"
                        type="text"
                        name="email"
                        value={email}
                        onChange={(e) => setEmail(e.target.value)}
                    />
                </div>
                <div className={"mb-3"}>
                    <input
                        placeholder="password"
                        type="password"
                        name="password"
                        value={password}
                        onChange={(e) => setPassword(e.target.value)}
                    />
                </div>
                <div className={"mb-3"}>
                    <button placeholder="submit" type="submit" className="btn btn-sm custom-button">
                        Log In
                    </button>
                </div>
            </form>
        </div>
    );
};

export default Login;