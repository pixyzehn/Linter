/**
 *  Linter
 *  Copyright (c) Nagasawa Hiroki 2017
 *  Licensed under the MIT license. See LICENSE file.
 */

import LinterCore

do {
    try Linter().run()
} catch {
    print("An error occurred: \(error)")
}
