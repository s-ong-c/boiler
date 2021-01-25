import React, { ReactElement } from 'react';

interface Props {
  children: React.ReactNode;
}

function Button({ children }: Props): ReactElement {
  return <div>{children}</div>;
}
export default Button;
