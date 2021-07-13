const path = require('path');

const SRC_DIR = path.resolve(__dirname, 'src');
const OUT_DIR = path.resolve(__dirname, 'dist');

module.exports = {
  entry: {
    getUsers: path.resolve(SRC_DIR, 'lambdas', 'getUsers.js'),
    getUser: path.resolve(SRC_DIR, 'lambdas', 'getUser.js'),
    createUser: path.resolve(SRC_DIR, 'lambdas', 'createUser.js'),
    deleteUser: path.resolve(SRC_DIR, 'lambdas', 'deleteUser.js'),
  },
  externals: ['aws-sdk'],
  output: {
    path: OUT_DIR,
    filename: '[name].js',
    library: '[name]',
    libraryTarget: 'umd',
  },
  target: 'node',
};
