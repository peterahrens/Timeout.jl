module Timeout
export timeout, TimeoutException

struct TimeoutException <: Exception end

function killtask(task)
    try
        Base.throwto(task, InterruptException())
    catch
    end
end

"""
    timeout(f, secs=3) -> Function

Return an anonymous function that calls function `f`. If the execution time of `f` exceeds `secs`, then throw the `TimeoutException`.
"""
function timeout(f, secs=3)
    function fn()
        done = Channel{Symbol}(1)
        result = Channel(1)

        timer_task = @async begin
            sleep(secs)
            put!(done, :timeout)
            put!(result, nothing)
        end

        main_task = @async begin
            put!(result, f())
            put!(done, :ok)
            killtask(timer_task)
        end

        state = fetch(done)
        r = fetch(result)
        close(done); close(result)
        if state == :timeout
            killtask(main_task)
            throw(TimeoutException())
        end

        return r
    end
end

end # module
