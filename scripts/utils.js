
const renameAllFiles = () => {
  const { join } = require('path');
  const { readdirSync, renameSync } = require('fs');


  const pathToDir = './The Elements of Programming';
  const searchString = 'Exercise ';
  const replaceString = '';

  const match = RegExp(searchString, 'g');
  const files = readdirSync(pathToDir);
  files
    .filter(file => file.match(match))
    .forEach(file => {
      console.log({ file });
      const filePath = join(pathToDir, file);
      const newFilePath = join(pathToDir, file.replace(match, replaceString));
      renameSync(filePath, newFilePath);
    });
};

renameAllFiles();