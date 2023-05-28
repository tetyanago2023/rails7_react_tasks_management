import React, { Fragment, useState } from 'react'
import { isProjectManager } from "../../helpers/user";
import { update } from "../../queries/Tasks";
import { Link } from "react-router-dom";

const TaskRow = ({ task, project, currentUser }) => {
    const [taskStatus, setTaskStatus] = useState(task.status)
    const [errors, setErrors] = useState('')

    const statusOptions = [
        { value: 'not_started', disabled: true },
        { value: 'working', disabled: task.employee_id !== currentUser.id || isProjectManager(currentUser) },
        { value: 'needs_review', disabled: task.employee_id !== currentUser.id || isProjectManager(currentUser) },
        { value: 'done', disabled: task.project_manager_id !== currentUser.id || !isProjectManager(currentUser)  },
    ]

    const updateStatus = (status) => setTaskStatus(status);
    const updateErrors = (errors) => setErrors(errors);

    const handleChange = async (event) => {
        await update({ id: task.id, status: event.target.value }, updateStatus, updateErrors)
    };

    return (
        <Fragment key={task.id}>
            <tr className={"table-warning"}>
                {errors}
                <td>{task.title}</td>
                <td>{task.description}</td>
                <td>{task.work_focus}</td>
                <td>{task.due_date}</td>
                <td>
                    <label>
                        <select value={taskStatus} onChange={handleChange}>
                            {
                                statusOptions.map(({value, disabled}) => (
                                    <option
                                        key={value}
                                        value={value}
                                        disabled={disabled}>
                                        {value}
                                    </option>
                                ))
                            }
                        </select>
                    </label>
                </td>
                <td>{task.project_manager?.name}</td>
                <td>{task.employee?.name}</td>
                <td>
                    {
                        !task.parent_task_id && <Link to={`/tasks/new?projectId=${project.id}&parentTaskId=${task.id}`}
                           className="btn btn-sm custom-button" role="button">
                            Add SubTask
                        </Link>
                    }
                </td>
            </tr>
            {
                task?.sub_tasks?.length > 0 &&
                <tr>
                    <td colSpan={7}>
                        <table className={'table mb-0'}>
                            {/*<tr>*/}
                                <thead className={"table-danger"}>
                                    <tr>
                                        <th scope="col">SubTask Title</th>
                                        <th scope="col">SubTask Description</th>
                                        <th scope="col">Work Focus</th>
                                        <th scope="col">Due Date</th>
                                        <th scope="col">Status</th>
                                        <th scope="col">Project Manager</th>
                                        <th scope="col">Employee Assigned To</th>
                                    </tr>
                                </thead>
                                <tbody>
                                {
                                    task.sub_tasks.map((subTask) => {
                                        return <TaskRow key={subTask.id}
                                                        task={subTask}
                                                        currentUser={currentUser}
                                                        project={project}/>
                                    })
                                }
                                </tbody>
                            {/*</tr>*/}
                        </table>
                    </td>
                </tr>

            }
        </Fragment>
    );
};

export default TaskRow;