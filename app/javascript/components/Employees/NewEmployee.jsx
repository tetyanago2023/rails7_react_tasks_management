import React, { useState } from 'react';
import { isProjectManager } from "../../helpers/user";
import { create } from "../../queries/Employees";
import { useNavigate } from "react-router-dom";

export const workFocusOptions = [
    'development',
    'design',
    'business',
    'research',
    'other'
]

const NewEmployee = ({ currentUser }) => {
    const navigate = useNavigate();
    const [email, setEmail] = useState('');
    const [name, setName] = useState('');
    const [title, setTitle] = useState('');
    const [workFocus, setWorkFocus] = useState(workFocusOptions[0]);
    const [errors, setErrors] = useState('');

    if(!isProjectManager(currentUser)) {
        navigate("/employees");
        return
    }

    const handleSuccess = () => {
        navigate("/employees")
    }

    const handleErrors = (errors) => {
        setErrors(errors)
    }

    const handleChangeWorkFocus = (event) => {
        setWorkFocus(event.target.value);
    };

    const handleSubmit = async (event) => {
        event.preventDefault();
        const employee = {
            email,
            name,
            title,
            work_focus: workFocus
        };
        await create(employee, handleSuccess, handleErrors)
    }

    return (
        <div>
            <h1>New Employee</h1>
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
                        placeholder="name"
                        type="text"
                        name="name"
                        value={name}
                        onChange={(e) => setName(e.target.value)}
                    />
                </div>
                <div className={"mb-3"}>
                    <input
                        placeholder="title"
                        type="text"
                        name="title"
                        value={title}
                        onChange={(e) => setTitle(e.target.value)}
                    />
                </div>
                <div className={"mb-3"}>
                    <label>
                        <div className={"mb-1"}>Work focus</div>
                        <select value={workFocus} onChange={handleChangeWorkFocus}>
                            {workFocusOptions.map((option) => (
                                <option key={option} value={option}>{option}</option>
                            ))}
                        </select>
                    </label>
                </div>
                <div className={"mb-3"}>
                    <button placeholder="submit" type="submit" className="btn btn-sm custom-button">
                        Submit
                    </button>
                </div>
            </form>
        </div>
    );
};

export default NewEmployee;