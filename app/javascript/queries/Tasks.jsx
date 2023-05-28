import axios from "axios";

export const create = async (task, callback = () => {}, errorCallback = () => {}) => {
    await axios.post(`http://localhost:3000/api/tasks`, { task })
        .then(response => {
            if (response.data.task) {
                callback(response.data.task.status)
            }
        })
        .catch(error => {
            console.log('api errors:', error)
            errorCallback(error.response.data.errors.join(' '))
        })
}

export const update = async (task, callback = () => {}, errorCallback = () => {}) => {
    await axios.patch(`http://localhost:3000/api/tasks/${task.id}`, { task })
        .then(response => {
            if (response.data.task) {
                callback(response.data.task.status)
            }
        })
        .catch(error => {
            console.log('api errors:', error)
            errorCallback(error)
        })
}