import faker from 'faker';

const tags = [] , tagsArraySize = 3;
for (let i = 0, l = tagsArraySize; i < l; i+=1) {
    tags.push({ 
        name: faker.internet.userName(),
        image: faker.image.imageUrl()
    });
}
export const tagsMock = tags;