import faker from 'faker';

const user = [];
const userArraySize = 3;

for (let i = 0, l = userArraySize; i < l; i += 1) {
    user.push({ 
        name: faker.internet.userName(),
        image: faker.image.imageUrl()
    });
}
export const userMock = user;
