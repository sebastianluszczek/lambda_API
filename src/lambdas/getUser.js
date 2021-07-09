const { res200, res400, res500 } = require('../utils/error.utils');
const { getOne } = require('../services/users.service');

exports.handler = async event => {
  if (!event.pathParameters || !event.pathParameters.ID) {
    return res400('missing ID from path');
  }
  let ID = event.pathParameters.ID;
  console.log(ID);

  try {
    const user = await getOne(ID);

    return res200(user);
  } catch (error) {
    return res500(error);
  }
};
