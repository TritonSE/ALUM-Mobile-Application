import mongoose from "mongoose";

interface PairingInterface {
  menteeId: string;
  mentorId: string;
  whyPaired: string;
}

interface PairingDoc extends mongoose.Document {
  menteeId: string;
  mentorId: string;
  whyPaired: string;
}

interface PairingModelInterface extends mongoose.Model<PairingDoc> {
  build(atrr: PairingInterface): PairingDoc;
}

const pairingSchema = new mongoose.Schema({
  menteeId: {
    type: String,
    required: true,
  },
  mentorId: {
    type: String,
    required: true,
  },
  whyPaired: {
    type: String,
    required: true,
  },
});

const Pairing = mongoose.model<PairingDoc, PairingModelInterface>("Pairing", pairingSchema);

export { Pairing, pairingSchema };
