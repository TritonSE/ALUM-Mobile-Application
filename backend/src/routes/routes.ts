import express , {Request, Response} from 'express'
import { User } from '../models/users'

const router = express.Router();

router.post('/api/user', async (req: Request, res: Response) => {
    const {name, email} = req.body;
    const user = User.build({name, email})
    await user.save();
    return res.status(201).send(user)
})

router.get('/api/user', [],  async (req: Request, res: Response) => {
    const user = await User.find({});
    return res.status(200).send(user);
})


export {router as userRouter}
