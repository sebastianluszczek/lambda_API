const { res204, res400, res500 } = require('../utils/error.utils');
const { deletoOne } = require('../services/users.service');

exports.handler = async event => {
  if (!event.pathParameters || !event.pathParameters.ID) {
    return res400('missing ID from path');
  }
  let ID = event.pathParameters.ID;

  try {
    await deletoOne(ID);

    return res204();
  } catch (error) {
    return res500(error);
  }
};
