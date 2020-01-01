// const data = [
//   {
//     id: 8,
//     number: "123456",
//     revoked: false,
//     createdAt: "2019-12-27T12:26:48.091Z",
//     exportedAt: null,
//     importRate: 92,
//     exportRate: null,
//     serial: "00011234567891",
//     trusteeId: 3,
//     lotteryDataId: "0001",
//     storeId: "12345678",
//     deviceId: "A6F33240-ED7D-453C-8485-282F4BF35344",
//     exporter: null
//   }
// ];

const _ = require("lodash");

const data = [
  {
    platformId: 1,
    payout: 15,
    numOfPeople: 4
  },
  {
    platformId: 1,
    payout: 12,
    numOfPeople: 3
  },
  {
    platformId: 2,
    payout: 6,
    numOfPeople: 5
  },
  {
    platformId: 2,
    payout: 10,
    numOfPeople: 1
  }
];

// const ans = _(data)
//   .groupBy("platformId")
//   .map((platform, id) => ({
//     platformId: id,
//     payout: _.sumBy(platform, "payout"),
//     numOfPeople: _.sumBy(platform, "numOfPeople")
//   }))
//   .value();

// console.log(ans);

const conntBy = _.countBy(data, "platformId");

console.log(conntBy);
