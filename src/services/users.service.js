const AWS = require('aws-sdk');
const { v4: uuidv4 } = require('uuid');

const TableName = process.env.tableName || 'users';

let options = {};
if (process.env.IS_OFFLINE) {
  options = {
    region: 'localhost',
    endpoint: 'http://localhost:8000',
  };
}

if (process.env.MOCK_DYNAMODB_ENDPOINT) {
  options = {
    endpoint: process.env.MOCK_DYNAMODB_ENDPOINT,
    region: 'local-env',
    sslEnabled: false,
  };
}

const docClient = new AWS.DynamoDB.DocumentClient(options);

exports.createOne = async user => {
  user = { ...user, ID: uuidv4() };
  const params = {
    TableName,
    Item: user,
  };
  await docClient.put(params).promise();

  return user;
};

exports.getAll = async () => {
  const params = {
    TableName,
  };

  const data = await docClient.scan(params).promise();

  return data.Items;
};

exports.getOne = async ID => {
  const params = {
    TableName,
    Key: {
      ID,
    },
  };
  const data = await docClient.get(params).promise();

  return data.Item;
};

exports.deletoOne = async ID => {
  const params = {
    TableName,
    Key: {
      ID,
    },
  };

  await docClient.delete(params).promise();

  return;
};
