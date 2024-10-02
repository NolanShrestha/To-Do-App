const { DataTypes } = require('sequelize');
const sequelize = require('../config/database');
const User = require('./user');

const TaskDetail = sequelize.define('TaskDetail', {
  id: {
    type: DataTypes.INTEGER,
    autoIncrement: true,
    primaryKey: true,
  },
  userId: {
    type: DataTypes.INTEGER,
    allowNull: false,
    references: {
      model: User,
      key: 'id',
    },
  },
  title: {
    type: DataTypes.STRING,
    allowNull: false,
  },
  body: {
    type: DataTypes.TEXT,
    allowNull: false,
  },
  date: {
    type: DataTypes.DATE,
    allowNull: false,
  },
});

TaskDetail.belongsTo(User, { foreignKey: 'userId' });
User.hasMany(TaskDetail, { foreignKey: 'userId' });

module.exports = TaskDetail;