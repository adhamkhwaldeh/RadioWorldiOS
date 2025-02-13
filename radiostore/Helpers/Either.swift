import Foundation

public enum Either<A,E> {
    case success(A)
    case failure(E)
}

extension Either: Equatable where A: Equatable, E: Equatable {}

public extension Either {
    func map<B>(_ f: (A) -> B) -> Either<B,E> {
        switch self {
        case let .success(a): return .success(f(a))
        case let .failure(e): return .failure(e)
        }
    }
    
    func flatMap<B>(_ f: (A) -> Either<B,E>) -> Either<B,E> {
        switch self {
        case let .success(a): return f(a)
        case let .failure(e): return .failure(e)
        }
    }
}

public extension Either {
    func toOptional() -> Optional<A> {
        switch self {
        case let .success(a): return .some(a)
        case _: return .none
        }
    }
}

public func flipEither<A,E1,E2>(_ x: Either<Either<A,E1>, E2>) -> Either<Either<A,E2>, E1> {
    switch x {
    case let .success(.success(x)): return .success(.success(x))
    case let .success(.failure(e)): return .failure(e)
    case let .failure(e): return .success(.failure(e))
    }
}

public func joinEither<A,E>(_ x: Either<Either<A,E>, E>) -> Either<A,E> {
    switch x {
    case let .success(.success(x)): return .success(x)
    case let .success(.failure(e)): return .failure(e)
    case let .failure(e): return .failure(e)
    }
}

public extension Optional {
    func toEither<E>(_ e: E) -> Either<Wrapped, E> {
        switch self {
        case let .some(x): return .success(x)
        case .none: return .failure(e)
        }
    }
}
