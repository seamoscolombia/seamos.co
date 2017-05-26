import faker from 'faker';

const polls = [];
const pollsArraySize = 3;

for (let i = 0, l = pollsArraySize; i < l; i += 1) {
    polls.push({
        already_voted: false, 
        description: faker.lorem.sentence(), 
        id: 1, 
        title: faker.lorem.words(3), 
        type: null
    });
}
export const pollsMock = polls;
