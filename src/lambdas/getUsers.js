const { res200, res500 } = require('../utils/error.utils');
const { getAll } = require('../services/users.service');

exports.handler = async () => {
  try {
    const users = await getAll();

    return res200(users);
  } catch (error) {
    console.log(error);
    return res500(error);
  }
};
