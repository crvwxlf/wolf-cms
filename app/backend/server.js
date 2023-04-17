import express from "express"
import chalk from "chalk"
import moment  from "moment"
import { logger } from './logger.js'

const PORT = process.env.PORT || 3000

const app = express()

app.get('/', (_, res) => {
    res.json({"message": "Hello world"})
})


app.listen(PORT, () => {
    logger.info(`Server started at port : ${PORT}`)
    console.info(`${chalk.yellow(`[${moment().format('DD/MM/YY HH:mm')}]`)} ${chalk.green('Server started at port: ' + PORT)}`)
})