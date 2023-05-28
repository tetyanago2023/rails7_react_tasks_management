import React, { useEffect, useState } from 'react';
import { isProjectManager } from "../../helpers/user";
import { useNavigate, useSearchParams } from "react-router-dom";
import { create } from "../../queries/Tasks";
import { index } from "../../queries/Employees";
import { workFocusOptions } from "../Employees/NewEmployee";

const NewTask = ({ currentUser }) => {
    const navigate = useNavigate();
    const [searchParams] = useSearchParams();
    const projectId = searchParams.get("projectId")
    const parentTaskId = searchParams.get("parentTaskId")

    const [title, setTitle] = useState('');
    const [description, setDescription] = useState('');
    const [workFocus, setWorkFocus] = useState(workFocusOptions[0]);
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

    const handleSuccess = () => {
        navigate("/projects")
    }

    const handleErrors = (errors) => {
        setErrors(errors)
    }

    const handleChange = (event) => {
        setEmployeeId(event.target.value);
    };

    const handleChangeWorkFocus = (event) => {
        setWorkFocus(event.target.value);
    };

    const handleSubmit = async (event) => {
        event.preventDefault();
        const task = {
            ...(!!parentTaskId && { parent_task_id: parentTaskId }),
            title,
            description,
            work_focus: workFocus,
            due_date: dueDate,
            employee_id: employeeId,
            project_id: projectId,
        };
        await create(task, handleSuccess, handleErrors)
    }
    return (
        <div>
            <h1>New Task</h1>
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
                        <div className={"mb-1"}>Work focus</div>
                        <select value={workFocus} onChange={handleChangeWorkFocus}>
                            {workFocusOptions.map((option) => (
                                <option key={option} value={option}>{option}</option>
                            ))}
                        </select>
                    </label>
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

export default NewTask;