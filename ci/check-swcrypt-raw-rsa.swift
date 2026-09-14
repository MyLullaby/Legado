import Foundation

// Reuses the raw RSA fixture in JavaBridgeCompatTests without requiring the app.
@main
struct RawRSACheck {
    static func main() throws {
        precondition(CC.RSA.available())
        let ciphertext = Data(base64Encoded: "ASDE5778NcXx7aJ7rSOlAHLZR65LUhPIgWu+jhp4bzc5wEKigUEd4zpDppRMF/mOONVtiVZ5xU7XiFpM2CgyZUCOkyXd3Ic5ClCJQBvRGuB2pBWhnNAxo5JY5PV+p0zMfCXqrMM4RlyfbjRRK8Gafr/d4qsTzQH/4c7sc6DT6QvBka5DeWluM86+RLL9Iu9Sqwjn7vz+m7HnDA5hdrbvEuA7P1lakLTAabOqurp7qSBb8tI96Wij1E7fNJjENPg6QDkOVFC4uWD5CdGVxNu6u80JoewKyesxUrXUFs+kHew82zsVWAkteKTNOvcHJZzyYPIa9Pr18QidoqAERrYJ8w==")!
        let publicKey = Data(base64Encoded: "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjYFYoMbA0uW8by6+YIghxxsvibS9YW4yKVSulykAzZZwZ/+dNTkZ4inY7Pj08aksm6RCGKS6+WfvVQo/EdkcS5p2LY2/76qVzapyHsyQf/Pud6ATPKnwxNt/DaqjL35Z9K0NI/RF9x732RdIEOTKXppfRdzCa/1Ctm/5ZFilY8UmZsppkjDd3XkuPr3n3wVC8WFvqmdJ1N55prRlnaRaO+mIOXo3OsOzIxE5EdcE0TLT9OFZ3Wlbi3E0iI0v/ZsrWoL57YvLwo7BsARp7BansDCx8NZg6ObGQN/tNrE/nKqQTXeJjnFWXdLfhI7xivPPphkj5fNpiufIsIUEd7eXBwIDAQAB")!
        let derKey = PKCS8.PublicKey.stripHeaderIfAny(publicKey)!
        let (plaintext, blockSize) = try CC.RSA.rawCrypt(ciphertext, derKey: derKey)
        precondition(blockSize == 256 && plaintext.count == 256)
        precondition(String(decoding: plaintext.drop(while: { $0 == 0 }), as: UTF8.self).contains("夜间的泰山"))
        print("Raw RSA fixture passed (2048-bit key)")
    }
}
