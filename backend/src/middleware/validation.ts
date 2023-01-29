import { validationResult } from "express-validator";
import { Request, Response, NextFunction } from "express";

/**
 * Reject a request with status 400 if it does not proper specificaitons
 */
const validation = (req: Request, res: Response, next: NextFunction) => {
    const validateResponse = validationResult(req);
    if(validateResponse.isEmpty()) {
        return next();
    } else {
        const errors = validateResponse.array();
        const badFields = new Set(errors.map((error) => `${error.param} (${error.msg})`));
        return res.status(400).json({
            message: `Invalid or missing fields: ${[...badFields].join(", ")}`,
        });
    }
}
