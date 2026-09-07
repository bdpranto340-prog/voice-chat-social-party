const mongoose = require('mongoose');

const sessionSchema = new mongoose.Schema(
  {
    userId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
      required: true,
    },
    socketId: {
      type: String,
      required: true,
    },
    roomId: {
      type: mongoose.Schema.Types.ObjectId,
      ref: 'Room',
      default: null,
    },
    isInCall: {
      type: Boolean,
      default: false,
    },
    connectedUsers: [{
      type: mongoose.Schema.Types.ObjectId,
      ref: 'User',
    }],
    startTime: Date,
    endTime: Date,
    ipAddress: String,
    userAgent: String,
    isActive: {
      type: Boolean,
      default: true,
    },
    createdAt: {
      type: Date,
      default: Date.now,
      index: true,
      expires: 86400, // Auto delete after 24 hours
    },
    updatedAt: {
      type: Date,
      default: Date.now,
    },
  },
  { timestamps: true }
);

// Index for faster queries
sessionSchema.index({ userId: 1, isActive: 1 });
sessionSchema.index({ socketId: 1 });

module.exports = mongoose.model('Session', sessionSchema);