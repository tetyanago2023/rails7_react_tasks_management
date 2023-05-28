import React, { useEffect, useState } from 'react';
import { useNavigate } from "react-router-dom";
import { index } from "../../queries/Employees";
import { create } from "../../queries/Projects";
import { isProjectManager } from "../../helpers/user";

const New = ({currentUser}) => {
    const navigate = useNavigate();

    const [title, setTitle] = useState('');
    const [description, setDescription] = useState('');
    const [dueDate, setDueDate] = useState('');
    const [employeeId, setEmployeeId] = useState('not_selected');
    const [employees, setEmployees] = useState([]);
    const [errors, setErrors] = useState('');

    // Fetch employees
    useEffect(() => {
        (async () => {
            const employeesData = await index();
            if (!!employeesData) {
                setEmployees(employeesData);
            }
        })()
    }, []);

    if(!isProjectManager(currentUser)) {
        navigate("/projects");
        return
    }

    const handleChange = (event) => {
        setEmployeeId(event.target.value);
    };

    const handleSubmit = async (event) => {
        event.preventDefault();
        const project = {
            title,
            description,
            due_date: dueDate,
            employee_id: employeeId,
        };
        await create(project, () => (navigate("/projects")), (errors) => setErrors(errors))
    }
    return (
        <div>
            <h1>New Project</h1>
            {errors}
            <form onSubmit={handleSubmit}>
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
                    <input
                        placeholder="description"
                        type="text"
                        name="description"
                        value={description}
                        onChange={(e) => setDescription(e.target.value)}
                    />
                </div>
                <div className={"mb-3"}>
                    <label>
                        <div className={"mb-1"}>Due Date</div>
                        <input
                            type="date"
                            name="due_date"
                            value={dueDate}
                            onChange={(e) => setDueDate(e.target.value)}
                        />
                    </label>
                </div>
                <div className={"mb-3"}>
                    <label>
                        <div className={"mb-1"}>Employee</div>
                        <select value={employeeId} onChange={handleChange}>
                            <option disabled value={'not_selected'}> -- select an option -- </option>
                            {employees.map((option) => (
                                <option key={option.id} value={option.id}>{option.name}</option>
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

export default New;

