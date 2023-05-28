import axios from "axios";

export const index = async () => {
    const result = await axios.get('http://localhost:3000/api/employees')
        .then(response => {
            return response.data.employees
        })
        .catch(error => console.log('api errors:', error))

    return result
}

export const create = async (employee, callback = () => {}, errorCallback = () => {}) => {
    await axios.post(`http://localhost:3000/api/employees`, { employee })
        .then(response => {
            if (response.data.employee) {
                callback(response.data.employee)
            }
        })
        .catch(error => {
            console.log('api errors:', error)
            errorCallback(error.response.data.errors.join(' '))
        })
}
