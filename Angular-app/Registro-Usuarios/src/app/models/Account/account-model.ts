export interface AccountLogin {
  response: LoginResponse
}

export interface LoginResponse {
  response: string,
  token: string,
  expires: Date
}
