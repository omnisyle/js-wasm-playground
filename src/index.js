import lodash from "lodash"

function square(n) {
  return n*n;
}

export default function(input) {
  const ar = [1,2,3];
  const squared = lodash.map(ar, square);

  const inputN = input.n;

  const foo = squared.join("") + inputN;

  return { foo: foo, newBar: input.bar + "!" };
};
