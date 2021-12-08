import 'package:rent_ed/models/Property.dart';
import 'package:rent_ed/models/Profile.dart';

class Utils {
  static Profile getProfile() {
    return Profile(
      firstName: 'Jane',
      lastName: 'Sterling',
      id: '001',
      phoneNumber: 8788877890,
      image: 'assets/images/avatar.png',
      listings: null,
      ratings: 5,
      password: 'password',
      schoolEmail: 'jsterling@fandm.edu',
      university: 'Franklin and Marshall College',
      location: 'Lancaster, PA',
    );
  }

  static List<Property> getListing() {
    //first image is the most important and will be diplayed on the card
    final List<Property> properties = [
      Property(
        name: 'Luxury House',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Risus condimentum nulla diam proin quis commodo malesuada. Dolor morbi egestas consectetur egestas aliquam tellus. Accumsan tristique consequat nec cras commodo et orci ipsum, convallis. Lectus nibh ut eget quis quis praesent pellentesque. Molestie a id potenti vivamus blandit aliquet iaculis sed. Amet ut rutrum mauris gravida pellentesque eget in in potenti.',
        price: '\$1599/month',
        rating: '2',
        images: [
          'assets/images/HomeGrid1.png',
          'assets/images/HomeGrid1.png',
          'assets/images/HomeGrid1.png',
        ],
        location: 'Franklin & Marshall',
        availability: 'AVAILABLE',
        ownersProfile: 'assets/images/ownersImage.png',
      ),
      Property(
        name: 'Boujee House',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Risus condimentum nulla diam proin quis commodo malesuada. Dolor morbi egestas consectetur egestas aliquam tellus. Accumsan tristique consequat nec cras commodo et orci ipsum, convallis. Lectus nibh ut eget quis quis praesent pellentesque. Molestie a id potenti vivamus blandit aliquet iaculis sed. Amet ut rutrum mauris gravida pellentesque eget in in potenti.',
        price: '\$1599/month',
        rating: '2',
        images: [
          'assets/images/HomeGrid1.png',
          'assets/images/HomeGrid1.png',
          'assets/images/HomeGrid1.png'
        ],
        location: 'Franklin & Marshall',
        availability: 'AVAILABLE',
        ownersProfile: 'assets/images/ownersImage.png',
      ),
      Property(
        name: 'Poor House',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Risus condimentum nulla diam proin quis commodo malesuada. Dolor morbi egestas consectetur egestas aliquam tellus. Accumsan tristique consequat nec cras commodo et orci ipsum, convallis. Lectus nibh ut eget quis quis praesent pellentesque. Molestie a id potenti vivamus blandit aliquet iaculis sed. Amet ut rutrum mauris gravida pellentesque eget in in potenti.',
        price: '\$1599/month',
        rating: '2',
        images: [
          'assets/images/HomeGrid1.png',
          'assets/images/HomeGrid1.png',
          'assets/images/HomeGrid1.png'
        ],
        location: 'Franklin & Marshall',
        availability: 'AVAILABLE',
        ownersProfile: 'assets/images/ownersImage.png',
      ),
      Property(
        name: 'Below the means House',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Risus condimentum nulla diam proin quis commodo malesuada. Dolor morbi egestas consectetur egestas aliquam tellus. Accumsan tristique consequat nec cras commodo et orci ipsum, convallis. Lectus nibh ut eget quis quis praesent pellentesque. Molestie a id potenti vivamus blandit aliquet iaculis sed. Amet ut rutrum mauris gravida pellentesque eget in in potenti.',
        price: '\$1599/month',
        rating: '2',
        images: [
          'assets/images/HomeGrid1.png',
          'assets/images/HomeGrid1.png',
          'assets/images/HomeGrid1.png'
        ],
        location: 'Franklin & Marshall',
        availability: 'AVAILABLE',
        ownersProfile: 'assets/images/ownersImage.png',
      ),
    ];
    return properties;
      //first image is the most important and will be diplayed on the card
  }

  static List<String> getRegisterHintTexts() {
  
    final List<String> registerHintTexts = [
      'Email Address',
      'First Name',
      'Last Name',
      'School',
      'Enter a Password',
      'Re-type password',
    ];
    return registerHintTexts;
  }

    static List<String> getLogInHintTexts() {
  
    final List<String> registerHintTexts = [
      'Email Address',
      'Passwrod',
    ];
    return registerHintTexts;
  }
}
