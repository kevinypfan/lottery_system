import 'package:graphql/client.dart';

import '../config/config.dart';

final HttpLink _httpLink = HttpLink(
  uri: Config.API_URI,
);

// final AuthLink _authLink = AuthLink(
//   getToken: () async => 'Bearer $YOUR_PERSONAL_ACCESS_TOKEN',
// );

// final Link _link = _authLink.concat(_httpLink);

final GraphQLClient graphQLClient = GraphQLClient(
  cache: InMemoryCache(),
  link: _httpLink,
);
